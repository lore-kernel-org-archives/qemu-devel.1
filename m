Received: from eggs.gnu.org ([2001:4830:134:3::10]:44037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eoA0l-0003pK-KK
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:39:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eoA0k-0004Jh-RQ
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:39:19 -0500
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:36357)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eoA0k-0004In-L3
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:39:18 -0500
Received: by mail-ot0-x232.google.com with SMTP id b15so5813265otf.3
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 07:39:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180220134723.11776-1-kraxel@redhat.com>
References: <20180220134723.11776-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Feb 2018 15:38:57 +0000
Message-ID: <CAFEAcA-PZ6pNYAYAx=FO79CKJXBgnLLYoxcRw=zSBj_2_X3isw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/12] Ui 20180220 patches
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

On 20 February 2018 at 13:47, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit afd3397a8149d8b645004e459bf2002d78f5e267:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-request' into staging (2018-02-19 16:44:12 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20180220-pull-request
>
> for you to fetch changes up to 63ad932567df012ff4bf820a9ed0e2affd9dc5af:
>
>   ui: Reorder vte terminal packing to avoid gtk3 warnings (2018-02-20 12:16:11 +0100)
>
> ----------------------------------------------------------------
> ui: reorganize and cleanup display command line parsing.
> gtk: fix gtk3 warnings.
>
> ----------------------------------------------------------------
>
> Gerd Hoffmann (11):
>   vl: deprecate -no-frame
>   vl: rename DisplayType to LegacyDisplayType
>   gtk: add and use DisplayOptions + DisplayGTK
>   sdl: use DisplayOptions
>   vl: drop no_quit variable
>   egl-headless: use DisplayOptions
>   curses: use DisplayOptions
>   cocoa: use DisplayOptions
>   vl: drop full_screen variable
>   vl: drop request_opengl variable
>   vl: drop display_type variable
>
> Jan Kiszka (1):
>   ui: Reorder vte terminal packing to avoid gtk3 warnings

Applied, thanks.

-- PMM
