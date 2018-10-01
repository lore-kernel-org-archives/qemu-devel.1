Received: from eggs.gnu.org ([2001:4830:134:3::10]:42949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1g6szw-0003Fk-T4
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 03:52:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1g6szv-00029x-Ua
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 03:52:08 -0400
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:46304)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1g6szv-00029T-Q2
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 03:52:07 -0400
Received: by mail-yw1-xc41.google.com with SMTP id j202-v6so614698ywa.13
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 00:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20181001063803.22330-1-clg@kaod.org>
	<20181001063803.22330-8-clg@kaod.org>
In-Reply-To: <20181001063803.22330-8-clg@kaod.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 1 Oct 2018 00:51:55 -0700
Message-ID: <CAMo8Bf+2mjBruDo8ysfDDYj5qnHEofhtvoq5uSuuREyiNtOYTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 07/11] net: opencores_eth: convert
 SysBus init method to a realize method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: clg@kaod.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On Sun, Sep 30, 2018 at 11:38 PM C=C3=A9dric Le Goater <clg@kaod.org> wrote=
:
>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/net/opencores_eth.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max
