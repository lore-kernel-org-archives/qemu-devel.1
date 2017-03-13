Received: from eggs.gnu.org ([2001:4830:134:3::10]:43053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnUMB-0004HK-Mq
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:06:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnUMA-0001qV-GD
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:06:07 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:35166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cnUMA-0001px-9h
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:06:06 -0400
Received: by mail-wr0-x234.google.com with SMTP id g10so109111704wrg.2
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 11:06:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1489416908-3771-1-git-send-email-kwolf@redhat.com>
References: <1489416908-3771-1-git-send-email-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Mar 2017 19:05:44 +0100
Message-ID: <CAFEAcA9JoOLtUJAVhXijjDVZ4iTH_kYc3r03zmq7R58BesO1Jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/12] Block layer fixes for 2.9.0-rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 13 March 2017 at 15:54, Kevin Wolf <kwolf@redhat.com> wrote:
> The following changes since commit dd4d2578215cd380f40a38028a9904e15b135ef3:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/pull-fixes-20170309-1' into staging (2017-03-09 13:16:05 +0000)
>
> are available in the git repository at:
>
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to dcbf37ce41a52698550f8f8b2f14b5e6fee22d2d:
>
>   commit: Implement .bdrv_refresh_filename (2017-03-13 12:49:33 +0100)
>
> ----------------------------------------------------------------
> Block layer fixes for 2.9.0-rc1

We haven't had rc0 yet :-)

Applied, thanks.

-- PMM
