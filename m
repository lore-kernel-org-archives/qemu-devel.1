Received: from eggs.gnu.org ([209.51.188.92]:43687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lwhsu.freebsd@gmail.com>) id 1hLasi-00076D-Jz
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 18:05:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lwhsu.freebsd@gmail.com>) id 1hLahq-0007Ik-9p
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:54:31 -0400
MIME-Version: 1.0
References: <20190428155451.15653-1-thuth@redhat.com>
	<20190428155451.15653-6-thuth@redhat.com>
In-Reply-To: <20190428155451.15653-6-thuth@redhat.com>
From: Li-Wen Hsu <lwhsu@freebsd.org>
Date: Wed, 1 May 2019 06:54:15 +0900
Message-ID: <CAKBkRUwGEv2WsPdM0soWwaetfWU8m1fUkKN84H-tuYwOn7kPOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 5/8] cirrus / travis: Add gnu-sed and
 bash for macOS and FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Ed Maste <emaste@freebsd.org>, Christophe Fergeau <cfergeau@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Mon, Apr 29, 2019 at 12:55 AM Thomas Huth <thuth@redhat.com> wrote:
>
> We are going to enable the qemu-iotests during "make check" again,
> and for running the iotests, we need bash and gnu-sed.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Li-Wen Hsu <lwhsu@freebsd.org>
