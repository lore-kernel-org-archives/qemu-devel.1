Received: from eggs.gnu.org ([2001:4830:134:3::10]:33401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEd3j-0006T2-Di
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:23:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEd3f-0006zP-ED
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:23:31 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:56113)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eEd3f-0006yP-6h
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:23:27 -0500
Received: by mail-wm0-x22e.google.com with SMTP id 9so17189143wme.4
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 07:23:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1510625498-4821-1-git-send-email-jasowang@redhat.com>
References: <1510625498-4821-1-git-send-email-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Nov 2017 15:23:05 +0000
Message-ID: <CAFEAcA-_uA7Wt7EgD8D6M6U-Q=oNDqfPHrUbBVxYaKaoBf6SAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] Net patches
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

On 14 November 2017 at 02:11, Jason Wang <jasowang@redhat.com> wrote:
> The following changes since commit 4ffa88c99c54d2a30f79e3dbecec50b023eff1c8:
>
>   Merge remote-tracking branch 'remotes/berrange/tags/pull-qcrypto-2017-11-08-1' into staging (2017-11-10 16:01:35 +0000)
>
> are available in the git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to bb160b571fe469b03228d4502c75a18045978a74:
>
>   net/socket: fix coverity issue (2017-11-13 18:05:12 +0800)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
> Jens Freimann (2):
>       net: fix check for number of parameters to -netdev socket
>       net/socket: fix coverity issue
>
> Mao Zhongyi (4):
>       colo-compare: Insert packet into the suitable position of packet queue directly
>       colo-compare: compare the packet in a specified Connection
>       colo-compare: Fix comments
>       colo: Consolidate the duplicate code chunk into a routine
>
> Mike Nawrocki (2):
>       Fix eepro100 simple transmission mode
>       Add new PCI ID for i82559a

Applied, thanks.

-- PMM
