Received: from eggs.gnu.org ([2001:4830:134:3::10]:42693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d3OZ8-0004D6-Lr
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 11:09:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d3OZ4-0003Mc-J8
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 11:09:14 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:38219)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d3OZ4-0003MM-Cf
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 11:09:10 -0400
Received: by mail-wm0-x22c.google.com with SMTP id r190so7662342wme.1
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 08:09:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170426135707.5261-1-dgilbert@redhat.com>
References: <20170426135707.5261-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Apr 2017 16:08:48 +0100
Message-ID: <CAFEAcA_HL-6W_Z-FUoEG6pY0Yi3R_SsHr6gNDVf5EAp5zYSKMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/5] hmp queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>

On 26 April 2017 at 14:57, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit dcaed66cbe2803f9378f3a043c2e482bf8035dfd:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.10-20170426' into staging (2017-04-26 13:17:11 +0100)
>
> are available in the git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-hmp-20170426
>
> for you to fetch changes up to 78f86a2b7c6b5c490a612729816473485d7ac570:
>
>   tests: Add a tester for HMP commands (2017-04-26 14:42:31 +0100)
>
> ----------------------------------------------------------------
> HMP pull, with tcg fix
>
> ----------------------------------------------------------------
> Paolo Bonzini (1):
>       hmp: gpa2hva and gpa2hpa hostaddr command
>
> Thomas Huth (4):
>       monitor: Check whether TCG is enabled before running the "info jit" code
>       libqtest: Ignore QMP events when parsing the response for HMP commands
>       libqtest: Add a generic function to run a callback function for every machine
>       tests: Add a tester for HMP commands

Applied, thanks.

-- PMM
