Received: from eggs.gnu.org ([2001:4830:134:3::10]:54149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gZJ3t-00084m-AT
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 12:21:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gZJ3s-00018V-GL
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 12:21:41 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:36829)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gZJ3s-000186-B0
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 12:21:40 -0500
Received: by mail-oi1-x230.google.com with SMTP id x23so2592824oix.3
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 09:21:40 -0800 (PST)
MIME-Version: 1.0
References: <1545063690-10116-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1545063690-10116-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Dec 2018 17:21:27 +0000
Message-ID: <CAFEAcA8UhSdvk0zjGGtFDfCz6B+t0pcfaaxcZdfyeCgEf7Ws8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/13] qtest patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 17 Dec 2018 at 16:23, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter,
>
> the following changes since commit 139108f68486550869bd201f903f1884b78a4ae1:
>
>   .shippable.yml: disable the win cross tests (2018-12-17 13:02:12 +0000)
>
> are available in the git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2018-12-17
>
> for you to fetch changes up to fe17cca6bd2cdfb9cc7f29da8e71aa1238bcdba7:
>
>   tests/bios-tables-test: Sanitize test verbose output (2018-12-17 16:21:51 +0100)
>
> ----------------------------------------------------------------
> - Replace global_qtest in some tests
> - Exit boot-serial-test loop if child dies
> - Sanitize verbose output in biot-tables-test
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
