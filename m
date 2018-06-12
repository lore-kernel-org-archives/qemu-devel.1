Received: from eggs.gnu.org ([2001:4830:134:3::10]:40247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fSgBt-0006oi-0Q
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:06:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fSgBn-0007wG-Cn
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:06:16 -0400
Date: Tue, 12 Jun 2018 12:06:09 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180612100609.7k4u4a7quhqwjkjg@sirius.home.kraxel.org>
References: <20180608170933.9137-1-berrange@redhat.com>
	<20180608170933.9137-3-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180608170933.9137-3-berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/8] hw/usb: switch MTP to use new inotify
 APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Laurent Vivier <laurent@vivier.eu>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-trivial@nongnu.org, Eric Blake <eblake@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>

On Fri, Jun 08, 2018 at 06:09:27PM +0100, Daniel P. Berrang=E9 wrote:
> The internal inotify APIs allow alot of conditional statements to be
> cleared out, and provide a simpler callback for handling events.
>=20
> Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
