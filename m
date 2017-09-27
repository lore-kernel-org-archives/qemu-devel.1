Received: from eggs.gnu.org ([2001:4830:134:3::10]:57021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dxDnE-0001bv-02
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 10:58:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dxDnA-00027W-61
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 10:58:32 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:54695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dxDn9-000276-UU
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 10:58:28 -0400
Received: by mail-wr0-x236.google.com with SMTP id g29so16989727wrg.11
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 07:58:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170926110628.2705-1-kraxel@redhat.com>
References: <20170926110628.2705-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 27 Sep 2017 07:58:06 -0700
Message-ID: <CAFEAcA-orB+P0So5mr59EemeoYnVa7Hgcyor0ucbMKZYLq825A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Fw 20170926 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 26 September 2017 at 04:06, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit 1e3ee834083227f552179f6e43902cba5a866e6b:
>
>   Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault' into staging (2017-09-25 20:31:24 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/fw-20170926-pull-request
>
> for you to fetch changes up to 3d5eecab4a5a00df897253dda5792411a1872732:
>
>   Add --firmwarepath to configure (2017-09-26 13:05:32 +0200)
>
> ----------------------------------------------------------------
> add --firmwarepath to configure
>
> ----------------------------------------------------------------
>
> Gerd Hoffmann (2):
>   add qemu_add_data_dir()
>   Add --firmwarepath to configure
>
>  configure             |  6 ++++++
>  vl.c                  | 44 +++++++++++++++++++++++++++++++-------------
>  scripts/create_config |  2 +-
>  3 files changed, 38 insertions(+), 14 deletions(-)

Applied, thanks.

-- PMM
