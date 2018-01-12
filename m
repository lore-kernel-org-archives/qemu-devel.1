Received: from eggs.gnu.org ([2001:4830:134:3::10]:60636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZyKb-00020e-Vi
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:21:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZyKZ-0004tw-AG
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:21:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40098)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eZyKZ-0004sS-3t
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:21:07 -0500
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
	<1515756676-3860-5-git-send-email-pbonzini@redhat.com>
	<002101d38b9b$1f730620$5e591260$@ru>
	<80ed7db1-e4b4-923f-5da5-a839d0995ced@redhat.com>
	<002301d38b9f$710329d0$53097d70$@ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d4ee0cbb-f411-25ff-c804-dc7b58c9bb25@redhat.com>
Date: Fri, 12 Jan 2018 13:21:02 +0100
MIME-Version: 1.0
In-Reply-To: <002301d38b9f$710329d0$53097d70$@ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 04/52] hpet: recover timer offset correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: 'Maria Klimushenkova' <maria.klimushenkova@ispras.ru>, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>

On 12/01/2018 13:18, Pavel Dovgalyuk wrote:
>>> This revision is incorrect.
>>> Here is the latest one: https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg01751.html
>> _That_ version was posted on 10 Jan.
>>
>> _This_ version was posted on 11 Jan.  So this one is the latest one; the
>> latest one is wrong too.
> That's strange.
> I posted this version on 20 Dec: https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg04172.html

Hmm, my mistake then...

Paolo
