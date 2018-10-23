Received: from eggs.gnu.org ([2001:4830:134:3::10]:42769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gF1sr-0006CP-0R
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 14:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gF1sq-0000aC-6X
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 14:58:28 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:37205)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gF1sp-0000Zd-Oz
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 14:58:28 -0400
Received: by mail-ot1-x332.google.com with SMTP id o14so2497043oth.4
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 11:58:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181022123413.28044-1-armbru@redhat.com>
References: <20181022123413.28044-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Oct 2018 19:58:06 +0100
Message-ID: <CAFEAcA_4MgJ2kePp2mHY5jSFZ9xYGwU=qAYsCaenDw3_40LpDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/40] Error reporting patches for 2018-10-22
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

On 22 October 2018 at 13:33, Markus Armbruster <armbru@redhat.com> wrote:
> The following changes since commit 1b7490446bf41f54130c2d495dd4c8768c8e1ce3:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-3.1-pull-request' into staging (2018-10-19 11:20:05 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-error-2018-10-22
>
> for you to fetch changes up to 80313fb53d8048882848b6f63daaeb29dc319765:
>
>   error: Drop bogus "use error_setg() instead" admonitions (2018-10-19 15:47:09 +0200)
>
> ----------------------------------------------------------------
> Error reporting patches for 2018-10-22
>
> * Replace some unwise uses of error_report() & friends
> * Print error when using incorrect backend for debugcon
>


Applied, thanks.

-- PMM
