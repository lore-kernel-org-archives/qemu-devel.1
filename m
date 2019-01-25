Received: from eggs.gnu.org ([209.51.188.92]:58975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gn6S6-0005AD-Ah
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:43:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gn6S4-00059r-EF
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:43:42 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:42104)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gn6S4-00058C-98
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:43:40 -0500
Received: by mail-oi1-x232.google.com with SMTP id w13so8374260oiw.9
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 10:43:39 -0800 (PST)
MIME-Version: 1.0
References: <20190125140610.7810-1-ehabkost@redhat.com>
In-Reply-To: <20190125140610.7810-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Jan 2019 18:43:27 +0000
Message-ID: <CAFEAcA-SnzCxTwpa0LpKBpbv8sWZLEFW=ifKjNct8u2An-O1dw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Python 3 compatibility fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>

On Fri, 25 Jan 2019 at 14:06, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit 9dd0d8111fbb8015db75a38933aee1d45f9e64a3:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2019-01-24' into staging (2019-01-25 11:52:12 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/python-next-pull-request
>
> for you to fetch changes up to 651514df88fd53d537b3b78a7548663cc0816b1b:
>
>   decodetree: re.fullmatch was added in 3.4 (2019-01-25 11:41:42 -0200)
>
> ----------------------------------------------------------------
> Python 3 compatibility fixes
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
