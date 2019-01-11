Received: from eggs.gnu.org ([209.51.188.92]:48826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghuHy-00079z-Ej
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:43:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghuHx-0000vF-P8
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:43:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ghuHx-0000uo-Jf
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:43:45 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D1840C070E29
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 10:43:44 +0000 (UTC)
Date: Fri, 11 Jan 2019 11:43:43 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190111104343.msaz2y7bacuzr65m@sirius.home.kraxel.org>
References: <20190110120047.25369-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190110120047.25369-1-berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/3] Fix & improve icon display on GTK
 and SDL frontends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, Jan 10, 2019 at 12:00:44PM +0000, Daniel P. Berrang=E9 wrote:
> This series improves the GTK and SDL frontends so that they display the
> high quality QEMU logo.
>=20
> Changed in v2:
>=20
>   - Add a 'regenerate' make target in ui/icons to rebuild icons
>     from SVG using inkscape.
>   - Allow use of SDL_Image to be disabled with --enable-sdl-image
>     configure arg
>   - Reduce number of conditionals in SDL code
>   - Fix variable name typo in SDL code

Added to ui queue.

thanks,
  Gerd
