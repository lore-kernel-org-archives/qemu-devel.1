Received: from eggs.gnu.org ([2001:4830:134:3::10]:47580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d30pc-00008Q-Bo
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:48:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d30pb-0004FB-I7
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:48:40 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:36616)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d30pb-0004EM-AL
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:48:39 -0400
Received: by mail-wr0-x22d.google.com with SMTP id l50so35411672wrc.3
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 06:48:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1493119568-15218-1-git-send-email-jasowang@redhat.com>
References: <1493119568-15218-1-git-send-email-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Apr 2017 14:48:17 +0100
Message-ID: <CAFEAcA86Z3P65gtW-X52ff5ciaZueWurShyvnvpbAGxkc8G3cA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL V2 0/8] Net patches
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

On 25 April 2017 at 12:26, Jason Wang <jasowang@redhat.com> wrote:
> The following changes since commit 32c7e0ab755745e961f1772e95cac381cc68769d:
>
>   Merge remote-tracking branch 'remotes/juanquintela/tags/migration/20170421' into staging (2017-04-21 15:59:27 +0100)
>
> are available in the git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to 0fc8aec7de64f2bf83a274a2a38b938ce03425d2:
>
>   COLO-compare: Optimize tcp compare trace event (2017-04-25 19:17:25 +0800)
>
> ----------------------------------------------------------------
>
> Changes from V1:
> - Fix clang warnings
>

Applied, thanks.

-- PMM
