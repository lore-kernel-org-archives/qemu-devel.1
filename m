Received: from eggs.gnu.org ([209.51.188.92]:33728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gkGX0-0000I9-Hp
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 17:53:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gkGWz-0005hP-QY
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 17:53:02 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:37492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gkGWz-0005fU-JJ
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 17:53:01 -0500
Date: Thu, 17 Jan 2019 23:52:57 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190117225257.wksq4ar57nniqncv@function>
References: <20190117114359.5164-1-marcandre.lureau@redhat.com>
	<20190117114359.5164-22-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190117114359.5164-22-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 21/27] slirp: prefer c99 types over BSD kind
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

Marc-Andr=C3=A9 Lureau, le jeu. 17 janv. 2019 15:43:53 +0400, a ecrit:
> (indentation mess is hopefully going to be fixed when slirp is made a
> separate project and clang-format is applied over the history)

Yes, let's do it :)

Samuel
