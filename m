Received: from eggs.gnu.org ([2001:4830:134:3::10]:37981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTRvN-0005gk-8W
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:04:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTRvM-000632-BL
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:04:25 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:37354)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fTRvM-00062e-69
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:04:24 -0400
Received: by mail-oi0-x244.google.com with SMTP id l22-v6so5561584oib.4
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 06:04:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180613145351.414-1-jcody@redhat.com>
References: <20180613145351.414-1-jcody@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Jun 2018 14:04:03 +0100
Message-ID: <CAFEAcA8Ka5F+aoj2ZQ9CD_VYFOo8TCmmKDi1zNfsVHGYJq4bQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, Eric Blake <eblake@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 13 June 2018 at 15:53, Jeff Cody <jcody@redhat.com> wrote:
> The following changes since commit 2ab09bf2f9f55b9fb8d2de6eb2ba2a8570e268e2:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20180612-pull-request' into staging (2018-06-12 15:34:34 +0100)
>
> are available in the git repository at:
>
>   git://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request
>
> for you to fetch changes up to b61acdecbf19c3c5a327baec1e8e4c06d0da68b7:
>
>   block: Ignore generated job QAPI files (2018-06-13 10:51:49 -0400)
>
> ----------------------------------------------------------------
> Block patch for .gitignore
> ----------------------------------------------------------------
>
> Eric Blake (1):
>   block: Ignore generated job QAPI files
>
>  .gitignore | 4 ++++
>  1 file changed, 4 insertions(+)
>

Applied, thanks.

-- PMM
