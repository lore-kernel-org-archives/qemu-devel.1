Received: from eggs.gnu.org ([2001:4830:134:3::10]:38160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gMJ3J-0008Se-E6
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 15:43:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gMJ3A-0003T3-BS
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 15:43:16 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:58958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gMJ39-0003QF-Cj
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 15:43:12 -0500
Date: Mon, 12 Nov 2018 21:43:04 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20181112204304.3w4qdeycyyuucnwv@function>
References: <20181112202639.19228-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181112202639.19228-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] slirp: remove dead declarations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau, le mar. 13 nov. 2018 00:26:39 +0400, a ecrit:
> An overdue cleanup. Remaining declarations could probably be moved in
> other headers, such as slirp.h.

Applied to my tree, thanks!

Samuel
