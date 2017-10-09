Received: from eggs.gnu.org ([2001:4830:134:3::10]:51464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e1Rpa-0001N2-3s
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 02:46:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e1RpZ-0003L4-CH
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 02:46:26 -0400
References: <20171006235023.11952-1-f4bug@amsat.org>
	<20171006235023.11952-62-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f9370e2b-5342-0035-f8bb-f7896c5e7c16@redhat.com>
Date: Mon, 9 Oct 2017 08:46:09 +0200
MIME-Version: 1.0
In-Reply-To: <20171006235023.11952-62-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 61/88] tests: use g_new() family of
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Laurent Vivier <lvivier@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, qemu-block@nongnu.org

On 07.10.2017 01:49, Philippe Mathieu-Daud=C3=A9 wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> [PMD: split of some files in other commits of the same series, add libq=
test.c]
> ---
>  tests/ahci-test.c     | 4 ++--
>  tests/fw_cfg-test.c   | 4 ++--
>  tests/libqos/ahci.c   | 2 +-
>  tests/libqos/libqos.c | 2 +-
>  tests/libqos/malloc.c | 6 +++---
>  tests/libqtest.c      | 2 +-
>  tests/pc-cpu-test.c   | 2 +-
>  7 files changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
