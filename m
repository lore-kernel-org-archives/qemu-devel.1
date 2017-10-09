Received: from eggs.gnu.org ([2001:4830:134:3::10]:34523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e1UWN-0005k2-GJ
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 05:38:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e1UWM-0002bO-Mh
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 05:38:47 -0400
Date: Mon, 9 Oct 2017 11:38:39 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171009113839.497650b0.cohuck@redhat.com>
In-Reply-To: <20171006235023.11952-78-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
	<20171006235023.11952-78-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 77/88] dump: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>

On Fri,  6 Oct 2017 20:50:12 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  dump.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>
