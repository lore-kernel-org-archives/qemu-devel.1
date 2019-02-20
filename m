Received: from eggs.gnu.org ([209.51.188.92]:33293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gwLeT-0003HQ-Up
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 01:46:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gwLeT-0001mh-45
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 01:46:41 -0500
References: <1550591757-6192-1-git-send-email-thuth@redhat.com>
	<20190220063723.GA28876@richard>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <42b5707b-d2cd-25dc-082e-15a6269e9c9a@redhat.com>
Date: Wed, 20 Feb 2019 07:46:31 +0100
MIME-Version: 1.0
In-Reply-To: <20190220063723.GA28876@richard>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/ide/ich: Compile ich.c only if
 CONFIG_PCI is also set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-trivial@nongnu.org, yang.zhong@intel.com, qemu-devel@nongnu.org, pbonzini@redhat.com

On 20/02/2019 07.37, Wei Yang wrote:
> On Tue, Feb 19, 2019 at 04:55:57PM +0100, Thomas Huth wrote:
>> With the upcoming Kconfig-like build system, it will be easy to
>> build also version of QEMU that only contain a single machine. Some
> 
> Sorry for my poor English.
> 
> What is also version?

I mean "it will be easy to build a version of QEMU, too, that ...".
Maybe I should have rather written "it will be easy to build a binary of
QEMU, too, that ...".

 Thomas
