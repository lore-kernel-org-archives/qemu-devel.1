Received: from eggs.gnu.org ([2001:4830:134:3::10]:60221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e448I-0007Sw-5K
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:04:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e448D-0003bF-Ec
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:04:34 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:56735)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e448D-0003ah-8a
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:04:29 -0400
Received: by mail-wm0-x235.google.com with SMTP id l68so2473160wmd.5
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 05:04:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171012205330.29942-1-marcandre.lureau@redhat.com>
References: <20171012205330.29942-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Oct 2017 13:04:07 +0100
Message-ID: <CAFEAcA8F6-KnL7rAzDqG4qQ_=vf4fYZcXFVbvNyOe9AsxR=eBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/4] vhost-user patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 12 October 2017 at 21:53, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> The following changes since commit a0b261db8c030813e30a39eae47359ac2a37f7=
e2:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-re=
quest' into staging (2017-10-12 10:02:09 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/elmarco/qemu.git tags/vu-pull-request
>
> for you to fetch changes up to 13384f158ce043744cf7542162a34953c7e05a70:
>
>   libvhost-user: Support VHOST_USER_SET_SLAVE_REQ_FD (2017-10-12 16:57:50=
 +0200)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Dr. David Alan Gilbert (4):
>   libvhost-user: vu_queue_started
>   vhost-user-bridge: Only process received packets on started queues
>   libvhost-user: Update and fix feature and request lists
>   libvhost-user: Support VHOST_USER_SET_SLAVE_REQ_FD
>
>  contrib/libvhost-user/libvhost-user.h | 19 +++++++++++++++-
>  contrib/libvhost-user/libvhost-user.c | 43 +++++++++++++++++++++++++++++=
+-----
>  tests/vhost-user-bridge.c             |  1 +
>  3 files changed, 56 insertions(+), 7 deletions(-)

Applied, thanks.

-- PMM
