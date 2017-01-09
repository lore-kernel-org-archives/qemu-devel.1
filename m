Received: from eggs.gnu.org ([2001:4830:134:3::10]:60521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQbuQ-0002SD-6I
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 10:30:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQbuK-0005kK-Dh
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 10:30:54 -0500
Received: from mail-vk0-x234.google.com ([2607:f8b0:400c:c05::234]:33684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cQbuK-0005k2-8J
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 10:30:48 -0500
Received: by mail-vk0-x234.google.com with SMTP id 137so343550709vkl.0
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 07:30:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1483969476-7172-1-git-send-email-kwolf@redhat.com>
References: <1483969476-7172-1-git-send-email-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Jan 2017 15:30:26 +0000
Message-ID: <CAFEAcA-K9pCa1c8A2evnWb5yF0SGVziJS_jd8ueOttj1x4Df4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/14] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 9 January 2017 at 13:44, Kevin Wolf <kwolf@redhat.com> wrote:
> The following changes since commit ffe22bf51065dd33022cf91f77a821d1f11c250d:
>
>   Merge remote-tracking branch 'remotes/gonglei/tags/cryptodev-next-20161224' into staging (2017-01-06 15:18:09 +0000)
>
> are available in the git repository at:
>
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to c1bb86cd8ae67c14f79422b6e544d1e2bf40eeb2:
>
>   block: Rename raw-{posix,win32} to file-*.c (2017-01-09 13:30:53 +0100)
>
> ----------------------------------------------------------------
> Block layer patches
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
