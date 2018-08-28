Received: from eggs.gnu.org ([2001:4830:134:3::10]:46684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fubrz-00082n-Aq
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 07:09:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fubrw-0001yB-7I
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 07:09:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40724 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fubrw-0001y1-2X
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 07:09:08 -0400
Date: Tue, 28 Aug 2018 13:09:06 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180828110906.lx6oe3imlvfs6qve@sirius.home.kraxel.org>
References: <20180817173104.14691-1-marcandre.lureau@redhat.com>
	<CAJ+F1C+o2UPHZFMgEPUh8-DBVMCGc7zYhSfmn=wOYM5KT0RAgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1C+o2UPHZFMgEPUh8-DBVMCGc7zYhSfmn=wOYM5KT0RAgQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vnc: call sasl_server_init() only when
 required
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Aug 28, 2018 at 12:57:56PM +0200, Marc-Andr=E9 Lureau wrote:
> ping

patchew flagged a codestyle issue, I've expected to see a v2 with that
fixed ...

cheers,
  Gerd
