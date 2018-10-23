Received: from eggs.gnu.org ([2001:4830:134:3::10]:56932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gEzQ5-0006uV-MN
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 12:20:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gEzQ2-0001WK-PJ
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 12:20:37 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43237)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gEzPs-0001Ne-0a
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 12:20:28 -0400
Received: by mail-ot1-x341.google.com with SMTP id k9so1961558otl.10
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 09:20:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181021193014.22512-1-samuel.thibault@ens-lyon.org>
References: <20181021193014.22512-1-samuel.thibault@ens-lyon.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Oct 2018 17:19:56 +0100
Message-ID: <CAFEAcA-iEyTskdawHoLPSqZMq9o90v4gQjW8yJCc2Vot+T3Lfw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] slirp updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>

On 21 October 2018 at 20:30, Samuel Thibault
<samuel.thibault@ens-lyon.org> wrote:
> The following changes since commit b312532fd03413d0e6ae6767ec793a3e30f487b8:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2018-10-19 19:01:07 +0100)
>
> are available in the Git repository at:
>
>   https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
>
> for you to fetch changes up to 0fca92b9077af9817c04545cdfc519fe95c6fde9:
>
>   slirp: Implement RFC2132 TFTP server name (2018-10-21 21:24:55 +0200)
>
> ----------------------------------------------------------------
> Fam Zheng (2):
>   slirp: Add sanity check for str option length
>   slirp: Implement RFC2132 TFTP server name
>
> ----------------------------------------------------------------
> Fam Zheng (2):
>       slirp: Add sanity check for str option length
>       slirp: Implement RFC2132 TFTP server name
>


Applied, thanks.

-- PMM
