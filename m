Received: from eggs.gnu.org ([2001:4830:134:3::10]:34596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tournier.elie@gmail.com>) id 1f9TeZ-0006D0-CO
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 06:52:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tournier.elie@gmail.com>) id 1f9TeV-0000bU-CU
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 06:52:31 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:32878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tournier.elie@gmail.com>)
	id 1f9TeV-0000ab-6D
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 06:52:27 -0400
Received: by mail-wr0-x22d.google.com with SMTP id z73-v6so21837860wrb.0
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 03:52:27 -0700 (PDT)
Date: Fri, 20 Apr 2018 11:46:11 +0100
From: Elie Tournier <tournier.elie@gmail.com>
Message-ID: <20180420104611.GB16234@Nikki.localdomain>
References: <20180413135842.21325-1-tournier.elie@gmail.com>
	<20180420093253.GA16234@Nikki.localdomain>
	<20180420104444.fkchhoaxxas5bbt7@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420104444.fkchhoaxxas5bbt7@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [PATCH v3 0/3] Use SDL to create an OpenGL ES
 context for virglrenderer.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com

On Fri, Apr 20, 2018 at 12:44:44PM +0200, Gerd Hoffmann wrote:
> On Fri, Apr 20, 2018 at 10:32:53AM +0100, Elie Tournier wrote:
> > On Fri, Apr 13, 2018 at 02:58:39PM +0100, Elie Tournier wrote:
> > > Hi,
> > > 
> > Hello,
> > 
> > Humble ping.
> > This series is unreviewed.
> 
> Looks sane.  Plan to include it in the next pull request (unless
> something shows up in testing).  Waiting for 2.12 being released and
> master branch opening up for new development.

Nice.
Thank you very much.
> 
> cheers,
>   Gerd
> 
