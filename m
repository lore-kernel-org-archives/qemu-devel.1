Received: from eggs.gnu.org ([2001:4830:134:3::10]:39505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNEC0-0001SJ-55
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 04:07:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNEBz-0007gf-4E
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 04:07:20 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:37911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dNEBy-0007gN-Tj
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 04:07:19 -0400
Received: by mail-wm0-x231.google.com with SMTP id u195so12388223wmd.1
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 01:07:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170614075653.26420-1-kraxel@redhat.com>
References: <20170614075653.26420-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jun 2017 09:06:57 +0100
Message-ID: <CAFEAcA8KC6QEz8s6DCJ_RU7oCf-POJSBUQV6_EZinTise-LoUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 0/5] ui patch queue
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

On 14 June 2017 at 08:56, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
> Here is the ui patch queue.  Switches the default
> to gtk3 and sdl2 and fixes some bugs.
>
> This version drops the two patches adding deprecation
> warnings to configure.
>
> please pull,
>   Gerd
>
> The following changes since commit 3f0602927b120a480b35dcf58cf6f95435b3ae91:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170613' into staging (2017-06-13 15:49:07 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/pull-ui-20170614-1
>
> for you to fetch changes up to fe5c44f9c95be3f74fb58902077ac587998d1392:
>
>   spice: don't enter opengl mode in case another UI provides opengl support (2017-06-14 09:52:35 +0200)
>
> ----------------------------------------------------------------
> ui: prefer gtk3 and sdl2, various fixes.
>
> ----------------------------------------------------------------
> Gerd Hoffmann (3):
>       gtk: prefer gtk3 over gtk2
>       sdl: prefer sdl2 over sdl1
>       spice: don't enter opengl mode in case another UI provides opengl support
>
> Ian McKellar via Qemu-devel (1):
>       Improve Cocoa modifier key handling
>
> Jonathon Jongsma (1):
>       spice: Use proper enum type for kbd led stat

Applied, thanks.

-- PMM
