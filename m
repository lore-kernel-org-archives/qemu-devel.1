Received: from eggs.gnu.org ([2001:4830:134:3::10]:41202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fX5H8-0003Dy-2r
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 09:41:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fX5H7-0004jy-5u
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 09:41:54 -0400
Received: from mail-ot0-x22f.google.com ([2607:f8b0:4003:c0f::22f]:40970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fX5H6-0004hX-Pj
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 09:41:53 -0400
Received: by mail-ot0-x22f.google.com with SMTP id d19-v6so12315081oti.8
	for <qemu-devel@nongnu.org>; Sun, 24 Jun 2018 06:41:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180622184909.23381-1-ehabkost@redhat.com>
References: <20180622184909.23381-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 24 Jun 2018 14:41:31 +0100
Message-ID: <CAFEAcA8abFHM03ExFYkdRwb2Y_fKJrP9PevA36VQh0L4P-Zw=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] Python queue, 2018-06-22
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>

On 22 June 2018 at 19:49, Eduardo Habkost <ehabkost@redhat.com> wrote:
> The following changes since commit 7ed14cbf3cf083f125c079bd02b3215941853830:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2018-06-22' into staging (2018-06-22 17:08:58 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/python-next-pull-request
>
> for you to fetch changes up to bf20b675cc5a2568f1105c3577663978c5a13108:
>
>   Partially revert "python: futurize -f libfuturize.fixes.fix_absolute_import" (2018-06-22 15:45:42 -0300)
>
> ----------------------------------------------------------------
> Python queue, 2018-06-22
>
> * Partially revert commit that broke qmp-shell and other scripts
>   inside ./scripts/qmp
>

Applied, thanks.

-- PMM
