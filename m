Received: from eggs.gnu.org ([2001:4830:134:3::10]:60410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dGMh9-0006Hj-9z
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 05:47:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dGMh8-0000iW-J1
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 05:47:07 -0400
References: <20170526101337.4096-1-marcandre.lureau@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <4a3068f9-24e9-1e6f-1d51-3c3528bdd47f@msgid.tls.msk.ru>
Date: Thu, 1 Jun 2017 12:47:05 +0300
MIME-Version: 1.0
In-Reply-To: <20170526101337.4096-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qemu-ga: remove useless allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

26.05.2017 13:13, Marc-Andr=C3=A9 Lureau wrote:
> There is no need to duplicate a fixed string.

Applied to -trivial, thanks!

/mjt
