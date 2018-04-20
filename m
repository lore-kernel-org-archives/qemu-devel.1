Received: from eggs.gnu.org ([2001:4830:134:3::10]:58195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f9TX8-0001gV-7D
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 06:44:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f9TX4-0001uj-B2
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 06:44:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58996 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1f9TX4-0001uN-5x
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 06:44:46 -0400
Date: Fri, 20 Apr 2018 12:44:44 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180420104444.fkchhoaxxas5bbt7@sirius.home.kraxel.org>
References: <20180413135842.21325-1-tournier.elie@gmail.com>
	<20180420093253.GA16234@Nikki.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420093253.GA16234@Nikki.localdomain>
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
To: Elie Tournier <tournier.elie@gmail.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com

On Fri, Apr 20, 2018 at 10:32:53AM +0100, Elie Tournier wrote:
> On Fri, Apr 13, 2018 at 02:58:39PM +0100, Elie Tournier wrote:
> > Hi,
> > 
> Hello,
> 
> Humble ping.
> This series is unreviewed.

Looks sane.  Plan to include it in the next pull request (unless
something shows up in testing).  Waiting for 2.12 being released and
master branch opening up for new development.

cheers,
  Gerd
