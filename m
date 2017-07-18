Received: from eggs.gnu.org ([2001:4830:134:3::10]:53779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dXaeK-0003b8-GC
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 18:07:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dXaeF-0005Hq-KA
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 18:07:24 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:34185)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dXaeF-0005Hd-FA
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 18:07:19 -0400
Date: Tue, 18 Jul 2017 18:07:18 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170718220718.GA4079@flamenco>
References: <20170717101632.23247-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170717101632.23247-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] add scripts/git.orderfile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon, Jul 17, 2017 at 12:16:32 +0200, Gerd Hoffmann wrote:
> Based on a old patch by Laszlo.
> Time to get this in ...
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  scripts/git.orderfile | 29 +++++++++++++++++++++++++++++

Reviewed-by: Emilio G. Cota <cota@braap.org>

Been using this orderfile with format-patch lately, with good results.

		E.
