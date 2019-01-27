Received: from eggs.gnu.org ([209.51.188.92]:34647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnY7r-0005YK-56
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 19:16:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnXz9-0001ye-Rg
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 19:07:40 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:34666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gnXz9-0001yI-Jt
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 19:07:39 -0500
Date: Sun, 27 Jan 2019 01:07:37 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190127000737.tosbxqz5m56un7mt@function>
References: <20190117114359.5164-1-marcandre.lureau@redhat.com>
	<20190117114359.5164-8-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190117114359.5164-8-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/27] slirp: replace QEMU_PACKED with
 SLIRP_PACKED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, pbonzini@redhat.com, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>

Marc-Andr=C3=A9 Lureau, le jeu. 17 janv. 2019 15:43:39 +0400, a ecrit:
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Applied except the ones which are removed in the other thread, thanks!
