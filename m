Received: from eggs.gnu.org ([2001:4830:134:3::10]:37445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1egBjX-0007i4-EQ
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 10:52:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1egBjR-0004YT-JB
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 10:52:35 -0500
Received: from mail-oi0-x22c.google.com ([2607:f8b0:4003:c06::22c]:33074)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1egBjR-0004Y6-EG
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 10:52:29 -0500
Received: by mail-oi0-x22c.google.com with SMTP id l8so5403315oig.0
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 07:52:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1517213825-24085-1-git-send-email-jasowang@redhat.com>
References: <1517213825-24085-1-git-send-email-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jan 2018 15:52:08 +0000
Message-ID: <CAFEAcA84DZrp19=rxp5cnU1XkWXB3gL5CFKrdGM4iZq7NmqaAw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/6] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 29 January 2018 at 08:16, Jason Wang <jasowang@redhat.com> wrote:
> The following changes since commit e607bbee553cfe73072870cef458cfa4e78133=
e2:
>
>   Merge remote-tracking branch 'remotes/edgar/tags/edgar/xilinx-next-2018=
-01-26.for-upstream' into staging (2018-01-26 14:24:25 +0000)
>
> are available in the git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to bf4835a4d5338bb7424827715df22570a8adc67c:
>
>   MAINTAINERS: update Dmitry Fleytman email (2018-01-29 16:05:38 +0800)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
> Mao Zhongyi (2):
>       colo: modified the payload compare function
>       colo: compare the packet based on the tcp sequence number
>
> Philippe Mathieu-Daud=C3=A9 (1):
>       MAINTAINERS: update Dmitry Fleytman email
>
> Thomas Huth (3):
>       net: Allow hubports to connect to other netdevs
>       net: Allow netdevs to be used with 'hostfwd_add' and 'hostfwd_remov=
e'
>       qemu-doc: Get rid of "vlan=3DX" example in the documentation
>

Applied, thanks.

-- PMM
