Received: from eggs.gnu.org ([2001:4830:134:3::10]:43132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gF1uO-0007BF-0O
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 15:00:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gF1uL-00026Q-VD
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 15:00:03 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:41045)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gF1uK-00024O-83
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 15:00:01 -0400
Received: by mail-oi1-x22a.google.com with SMTP id l197-v6so2020720oib.8
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 12:00:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181023130440.6323-1-armbru@redhat.com>
References: <20181023130440.6323-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Oct 2018 19:59:39 +0100
Message-ID: <CAFEAcA9Ob=W85L2wwPisS5p+k9Ah3V_mni3D-ociz-uf2nqL8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/40] Error reporting patches for
 2018-10-22
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

On 23 October 2018 at 14:04, Markus Armbruster <armbru@redhat.com> wrote:
> The following changes since commit b312532fd03413d0e6ae6767ec793a3e30f487b8:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2018-10-19 19:01:07 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-error-2018-10-22-v2
>
> for you to fetch changes up to 70f81ac4800c5cf33415c966d63bf89af5cefbb9:
>
>   error: Drop bogus "use error_setg() instead" admonitions (2018-10-23 14:48:32 +0200)
>
> ----------------------------------------------------------------
> Error reporting patches for 2018-10-22
>
> * Replace some unwise uses of error_report() & friends
> * Print error when using incorrect backend for debugcon
>
> ----------------------------------------------------------------
> v2: Fix a stale sentence in commit message of PATCH 05/40.

Sorry, I'd already pushed the merge of v1 to master before I saw this one.

-- PMM
