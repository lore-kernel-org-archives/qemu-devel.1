Received: from eggs.gnu.org ([2001:4830:134:3::10]:33040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eH7MF-00044v-DS
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 07:08:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eH7ME-0001Y7-IB
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 07:08:55 -0500
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:43841)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eH7ME-0001Xh-Ce
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 07:08:54 -0500
Received: by mail-wr0-x230.google.com with SMTP id u40so11073058wrf.10
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 04:08:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171120215034.22212-1-mdroth@linux.vnet.ibm.com>
References: <20171120215034.22212-1-mdroth@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Nov 2017 12:08:32 +0000
Message-ID: <CAFEAcA99nOg8ej7knwZUfz5oTVXej1XtgL_WTLZjdncGVf9fBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL for-2.11 0/1] qemu-ga patch queue for 2.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 20 November 2017 at 21:50, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> The following changes since commit b2996bb405e2806725a341c72d80be9e77ed8b82:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.11-20171120' into staging (2017-11-20 18:00:16 +0000)
>
> are available in the git repository at:
>
>   git://github.com/mdroth/qemu.git tags/qga-pull-2017-11-20-tag
>
> for you to fetch changes up to df83eabd5245828cbca32060aa191d8b03bc5d50:
>
>   qga: replace GetIfEntry with GetIfEntry2 for interface stats (2017-11-20 14:45:31 -0600)
>
> ----------------------------------------------------------------
> qemu-ga patch queue for 2.11
>
> * fix potential overflow in network interface stats reporting
>
> ----------------------------------------------------------------
> ZhiPeng Lu (1):
>       qga: replace GetIfEntry with GetIfEntry2 for interface stats
>
>  qga/commands-win32.c | 54 ++++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 38 insertions(+), 16 deletions(-)
>

Applied, thanks.

-- PMM
