Received: from eggs.gnu.org ([2001:4830:134:3::10]:54251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs1yY-0000qe-FB
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 04:25:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs1yV-0006UW-9E
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 04:25:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56112 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fs1yV-0006Tz-4K
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 04:25:15 -0400
Date: Tue, 21 Aug 2018 10:25:13 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180821082513.tpvlq4dbwyguurao@sirius.home.kraxel.org>
References: <20180801122410.10343-1-npes87184@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801122410.10343-1-npes87184@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] docs/usb2.txt: ehci has six ports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: npes87184 <npes87184@gmail.com>
Cc: qemu-devel@nongnu.org

On Wed, Aug 01, 2018 at 08:24:10PM +0800, npes87184 wrote:
> In commit 5cc194caeb019cf1dae7f74ccbdf0401a56c2ac6,
> the number of ehci ports is corrected to six. Fix docs
> related to it.

Added to usb queue.

> Signed-off-by: npes87184 <npes87184@gmail.com>

Please use your real name here next time.

Try 'git config --global user.name "Your Name"' and git will do it
automatically for you.

cheers,
  Gerd
