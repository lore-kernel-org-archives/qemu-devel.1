Received: from eggs.gnu.org ([2001:4830:134:3::10]:45319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gPbEf-0004wB-Bi
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:44:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gPbEb-0007k1-9A
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:44:41 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:33108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gPbEZ-0007Hh-8g
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:44:37 -0500
Date: Wed, 21 Nov 2018 23:43:39 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20181121224339.2cxzyoqe7rj2s5k6@function>
References: <20181121220647.18844-1-marcandre.lureau@redhat.com>
	<20181121220647.18844-24-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181121220647.18844-24-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 for-3.2 v2 23/30] slirp: replace
 DEBUG_ARGS with DEBUG_ARG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>

Marc-Andr=C3=A9 Lureau, le jeu. 22 nov. 2018 02:06:40 +0400, a ecrit:
> There is no clear benefit in calling an alias DEBUG_ARGS(). Replace
> calls with DEBUG_ARG(), and fix the white-spacing while at it.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Applied to my tree, thanks!
