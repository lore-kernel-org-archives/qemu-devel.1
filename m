Received: from eggs.gnu.org ([2001:4830:134:3::10]:40188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dGN8c-0003zg-Np
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 06:15:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dGN8Z-0002u5-Kr
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 06:15:30 -0400
References: <20170503223846.6559-1-marcandre.lureau@redhat.com>
	<20170503223846.6559-6-marcandre.lureau@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <ce17b7e5-3301-05a5-7cc2-a242245c949b@msgid.tls.msk.ru>
Date: Thu, 1 Jun 2017 13:15:26 +0300
MIME-Version: 1.0
In-Reply-To: <20170503223846.6559-6-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 5/5] dump: fix memory_mapping_filter leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: QEMU Trivial <qemu-trivial@nongnu.org>

04.05.2017 01:38, Marc-Andr=C3=A9 Lureau wrote:
> Spotted by ASAN.

Applied to -trivial. Thanks!

/mjt
