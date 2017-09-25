Received: from eggs.gnu.org ([2001:4830:134:3::10]:55714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dwPH5-0002uh-7d
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 05:02:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dwPGz-0004d2-Py
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 05:01:59 -0400
Date: Mon, 25 Sep 2017 10:01:44 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170925090144.GB14140@stefanha-x1.localdomain>
References: <20170922154014.29350-1-f4bug@amsat.org>
	<20170922154014.29350-5-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170922154014.29350-5-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/34] misc: remove headers implicitly
 included
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Ben Warren <ben@skyportsystems.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On Fri, Sep 22, 2017 at 12:39:44PM -0300, Philippe Mathieu-Daud=E9 wrote:
> applied using ./scripts/clean-includes
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  hw/audio/fmopl.h             | 1 -
>  bsd-user/main.c              | 1 -
>  chardev/wctablet.c           | 4 ----
>  hw/scsi/vhost-user-scsi.c    | 1 -
>  linux-user/main.c            | 1 -
>  net/colo-compare.c           | 1 -
>  tests/test-aio-multithread.c | 1 -
>  tests/test-clone-visitor.c   | 1 -
>  tests/vmgenid-test.c         | 3 ---
>  9 files changed, 14 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
