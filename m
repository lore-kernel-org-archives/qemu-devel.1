Received: from eggs.gnu.org ([2001:4830:134:3::10]:55436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csvZp-00088l-U9
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:10:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csvZp-00068X-29
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:10:41 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:34681)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1csvZo-00068Q-RV
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:10:40 -0400
Received: by mail-wr0-x233.google.com with SMTP id l43so111933343wre.1
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 11:10:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1490720098-4745-1-git-send-email-armbru@redhat.com>
References: <1490720098-4745-1-git-send-email-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Mar 2017 19:10:19 +0100
Message-ID: <CAFEAcA9nGgLEM+mZ+326PdoJGgHWzAukrJZsPunTfYABw1ALOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL for-2.9] Miscellaneous patches for 2017-03-28
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

On 28 March 2017 at 17:54, Markus Armbruster <armbru@redhat.com> wrote:
> The following changes since commit 4d2bee82f4276b6f694fa2b0b179b4b3673984f6:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-block-2017-03-28' into staging (2017-03-28 14:48:07 +0100)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-misc-2017-03-28
>
> for you to fetch changes up to 44fdc764550e048a2810955da7cabbfaf636231a:
>
>   sockets: Fix socket_address_to_string() hostname truncation (2017-03-28 18:50:38 +0200)
>
> ----------------------------------------------------------------
> Miscellaneous patches for 2017-03-28
>
> ----------------------------------------------------------------
> Markus Armbruster (1):
>       sockets: Fix socket_address_to_string() hostname truncation
>
>  util/qemu-sockets.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> Markus Armbruster (1):
>   sockets: Fix socket_address_to_string() hostname truncation
>
>  util/qemu-sockets.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)

Applied, thanks.

-- PMM
