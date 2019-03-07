Received: from eggs.gnu.org ([209.51.188.92]:46788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h1u3L-00072b-Nr
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:31:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h1u3K-0002Ik-Cb
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:31:19 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:58614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1h1u3K-0002Gr-57
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:31:18 -0500
Date: Thu, 7 Mar 2019 15:31:14 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190307143114.yxklfliii53pkijm@function>
References: <20190304210217.7056-1-samuel.thibault@ens-lyon.org>
	<20190307132112.4a7vkduflcgsfrym@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307132112.4a7vkduflcgsfrym@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [PATCHv2 0/2] curses: Add support for wide output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com, ekohler@gmail.com, eblake@redhat.com

Gerd Hoffmann, le jeu. 07 mars 2019 14:21:12 +0100, a ecrit:
> On Mon, Mar 04, 2019 at 10:02:15PM +0100, Samuel Thibault wrote:
> > This adds support for wide output in the curses frontend
> > 
> > Difference with previous version:
> > - Add more rationale in commit message
> > - Move charset option to curses-only section.
> 
> Added to UI patch queue (the other curses patches too).

Thanks!

Samuel
