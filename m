Received: from eggs.gnu.org ([2001:4830:134:3::10]:50364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fREpT-0000Av-5u
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 06:41:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fREpS-00040E-Ei
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 06:41:11 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:41350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fREpS-0003zW-7s
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 06:41:10 -0400
Received: by mail-ot0-x241.google.com with SMTP id d19-v6so9582974oti.8
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 03:41:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180608061316.4909-1-samuel.thibault@ens-lyon.org>
References: <20180608061316.4909-1-samuel.thibault@ens-lyon.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Jun 2018 11:40:49 +0100
Message-ID: <CAFEAcA8=E9w6ei7rbR71W80SfNHHrnao2dRVjyXuJR7K2=YrgQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] slirp updates
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

On 8 June 2018 at 07:13, Samuel Thibault <samuel.thibault@ens-lyon.org> wrote:
> The following changes since commit 9be4af13305f24d2dabf94bb53e6b65c76d08bb2:
>
>   Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault' into staging (2018-06-01 14:58:53 +0100)
>
> are available in the Git repository at:
>
>   https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
>
> for you to fetch changes up to c22098c74a09164797fae6511c5eaf68f32c4dd8:
>
>   slirp: reformat m_inc routine (2018-06-08 09:08:30 +0300)
>
> ----------------------------------------------------------------
> slirp updates
>
> Prasad J Pandit (2):
>   slirp: Fix buffer overflow on packet reassembling
>
> Samuel Thibault (3):
>   slirp: Add Samuel Thibault's staging tree for slirp
>   slirp: fix domainname version availability
>


Applied, thanks.

-- PMM
