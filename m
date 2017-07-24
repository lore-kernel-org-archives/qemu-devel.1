Received: from eggs.gnu.org ([2001:4830:134:3::10]:48277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dZgSD-0006Wo-Q6
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 12:43:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dZgS9-0007zp-SQ
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 12:43:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1dZgS9-0007zO-LV
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 12:43:29 -0400
References: <3E24AFDE-D25A-416B-A600-3C2221C3A9F1@gmail.com>
	<CAGCz3vu5x59+mKg8011=DRyZQKbuBV2F20ZpPnG1TOCxsOb+mQ@mail.gmail.com>
	<20170721110636.19412e6c@nial.brq.redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <56c4d877-58e8-b8ac-cc7f-e6cde5ddfa16@redhat.com>
Date: Mon, 24 Jul 2017 12:43:24 -0400
MIME-Version: 1.0
In-Reply-To: <20170721110636.19412e6c@nial.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Commit 77af8a2b95b79699de650965d5228772743efe84
 breaks Windows 2000 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, Phil Dennis-Jordan <lists@philjordan.eu>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, ehabkost@redhat.com, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Programmingkid <programmingkidx@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>



On 07/21/2017 05:06 AM, Igor Mammedov wrote:
> On Thu, 20 Jul 2017 21:29:33 +0200
> Phil Dennis-Jordan <lists@philjordan.eu> wrote:
> 
>> On Thu, Jul 20, 2017 at 6:40 PM, Programmingkid
>> <programmingkidx@gmail.com> wrote:
>>> I noticed that Windows 2000 does not boot up in QEMU recently. After bisecting the issue I found the offending commit:
> w2k is very ancient (and long time EOLed), I can't even download it from msdn to test
> (oldest available is XP)
> 
> do we really care about it?
> 

Red Hat: "No, not really."
FOSS: "Yes, of course!"

Half the fun of QEMU (see also: QEMU Advent Calendar) is running old 
software. Technology moves so fast that even software from just 17 years 
ago is becoming impossible to run.

For historical and archival purposes it is absolutely of interest to be 
able to run one of Microsoft's most popular operating systems.

Of course, it's not particularly high on anyone's list who is getting 
paid to tend to QEMU, of course.

--js
