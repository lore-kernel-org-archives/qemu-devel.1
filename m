Received: from eggs.gnu.org ([2001:4830:134:3::10]:48487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eECAR-0000Ki-7H
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 05:40:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eECAN-0005VM-6c
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 05:40:39 -0500
Date: Mon, 13 Nov 2017 11:40:32 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20171113104032.mchst26f5sskka3e@sirius.home.kraxel.org>
References: <1510564905-6185-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1510564905-6185-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] scripts/make-release: No need to delete
 pixman/.git anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org

On Mon, Nov 13, 2017 at 10:21:45AM +0100, Thomas Huth wrote:
> The pixman submodule has been removed in commit c12b6d70e384c769ca372e1,
> so there is no need anymore to delete pixman/.git while building a
> release tarball.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
