Received: from eggs.gnu.org ([209.51.188.92]:33556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1HIR-0002Ly-MC
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 16:08:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1HIM-0005bX-Ab
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 16:08:16 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:34050)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1HIC-0004j0-38
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 16:08:09 -0500
Received: by mail-oi1-x234.google.com with SMTP id g16so8037549oib.1
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 13:07:01 -0800 (PST)
MIME-Version: 1.0
References: <20190305165236.8389-1-armbru@redhat.com>
In-Reply-To: <20190305165236.8389-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2019 21:06:49 +0000
Message-ID: <CAFEAcA9L2Z+NXyBAHRGoj5wPzOferogVwGAdh2kd4iU7qwG+yw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] QAPI patches for 2019-03-05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Tue, 5 Mar 2019 at 17:07, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit 0984a157c1c053394adbf64ed7de97f1aebe6a2d:
>
>   Merge remote-tracking branch 'remotes/jasowang/tags/net-pull-request' into staging (2019-03-05 09:33:20 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2019-03-05
>
> for you to fetch changes up to 56a4689582433125d7042ba506a081e08dc264d4:
>
>   qapi: Fix array first used in a different module (2019-03-05 14:43:11 +0100)
>
> ----------------------------------------------------------------
> QAPI patches for 2019-03-05
>
> ----------------------------------------------------------------
> Markus Armbruster (7):
>       tests/qapi-schema: Make test-qapi.py print arrays
>       tests/qapi-schema: Cover conditional arrays
>       qapi: Pass file name to QAPIGen constructor instead of methods
>       qapi: Fix code generation for sub-modules in other directories
>       tests: Rename UserDefNativeListUnion to UserDefListUnion
>       tests/qapi-schema: Cover forward reference to sub-module
>       qapi: Fix array first used in a different module
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
