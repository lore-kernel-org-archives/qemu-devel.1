Received: from eggs.gnu.org ([2001:4830:134:3::10]:38155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cU645-0005Ql-6i
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 01:19:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cU640-0006JI-5u
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 01:19:17 -0500
Received: from [59.151.112.132] (port=64285 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cU63z-0006IF-P6
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 01:19:12 -0500
References: <1483175588-17006-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<20170118144321.38c984bf@t450s.home>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <58805BBF.3070509@cn.fujitsu.com>
Date: Thu, 19 Jan 2017 14:25:03 +0800
MIME-Version: 1.0
In-Reply-To: <20170118144321.38c984bf@t450s.home>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v11 0/4] vfio-pci: pass non-fatal error
 to guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, izumi.taku@jp.fujitsu.com



On 01/19/2017 05:43 AM, Alex Williamson wrote:
> On Sat, 31 Dec 2016 17:13:04 +0800

> How can you know if he other function was affected if you don't even
> have a cable connected?

Will try ask for another cable for the other function.

>  How is testing on something that doesn't seem
> to work correctly already valid?  Thanks,

Not sure I understand you right. Even if I find those abnormal
phenomenon in test, I finally got the very exact result I expected in
each scenario, does it enough to prove this new functionality works? and
especially these abnormal phenomenon exists even without this patchset

-- 
Sincerely,
Cao jin
