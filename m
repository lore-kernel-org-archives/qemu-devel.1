Received: from eggs.gnu.org ([2001:4830:134:3::10]:56227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e1uXO-0003yS-00
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:25:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e1uXJ-0005ND-3B
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:25:33 -0400
Date: Tue, 10 Oct 2017 15:25:20 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171010152520.4d77f7dc.cohuck@redhat.com>
In-Reply-To: <20171006235023.11952-27-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
	<20171006235023.11952-27-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 26/88] S390: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, qemu-s390x@nongnu.org

On Fri,  6 Oct 2017 20:49:21 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> [PMD: more changes in hw/s390x/css.c, added target/s390x/cpu_models.c]
> ---
>  hw/s390x/css.c            | 10 +++++-----
>  hw/s390x/s390-pci-bus.c   |  4 ++--
>  target/s390x/cpu_models.c | 12 ++++++------
>  target/s390x/diag.c       |  2 +-
>  4 files changed, 14 insertions(+), 14 deletions(-)

Thanks, applied.
