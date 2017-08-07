Received: from eggs.gnu.org ([2001:4830:134:3::10]:37440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eterrell@redhat.com>) id 1deiv4-0003m6-9h
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:22:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eterrell@redhat.com>) id 1deiv1-0005jt-11
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:22:10 -0400
Date: Mon, 7 Aug 2017 16:16:05 +0200
From: Eduardo Otubo <eterrell@redhat.com>
Message-ID: <20170807141604.GA14212@bluepex.com>
References: <20170728115131.31725-1-otubo@redhat.com>
	<a6feb869-e73e-ffd3-278e-23fef4ae6a0c@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a6feb869-e73e-ffd3-278e-23fef4ae6a0c@msgid.tls.msk.ru>
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] unicore32: abort when
 entering "x 0" on the monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Eduardo Otubo <otubo@redhat.com>, qemu-trivial@nongnu.org, thuth@redhat.com, gxt@mprc.pku.edu.cn, qemu-devel@nongnu.org

On Mon, Jul 31, 2017 at 01:17:03PM +0300, Michael Tokarev wrote:
> 28.07.2017 14:51, Eduardo Otubo wrote:
> > Starting Qemu with "qemu-system-unicore32 -M puv3,accel=qtest -S -nographic"
> > and entering "x 0 " at the monitor prompt leads to abort():
> 
> Applied to -trivial, thanks!
> 

Hi Michael, you missed this patch in the latest pull request. Care to
take it on the next one? I'm planning to send some other small fixes
until this Friday.

Regards,

-- 
Eduardo Otubo
Senior Software Engineer @ RedHat
