Received: from eggs.gnu.org ([2001:4830:134:3::10]:41949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dvQyY-00020Z-Dl
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:38:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dvQyX-0002Sc-FH
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:38:50 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:46288)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dvQyX-0002Ru-8L
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:38:49 -0400
Received: by mail-wr0-x233.google.com with SMTP id o42so1345035wrb.3
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 09:38:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170922144259.5956-1-ehabkost@redhat.com>
References: <20170922144259.5956-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Sep 2017 17:38:27 +0100
Message-ID: <CAFEAcA8OajziCMdYP6eF-VzFxFJDW+77G4jbe89eRRgh12YGjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Python next patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>

On 22 September 2017 at 15:42, Eduardo Habkost <ehabkost@redhat.com> wrote:
> The following changes since commit 9ee660e7c138595224b65ddc1c5712549f0a278c:
>
>   Merge remote-tracking branch 'remotes/yongbok/tags/mips-20170921' into staging (2017-09-21 14:40:32 +0100)
>
> are available in the git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/python-next-pull-request
>
> for you to fetch changes up to ad904f6689f1ced282b413cb904c166f294a73ee:
>
>   MAINTAINERS: Add Python scripts (2017-09-22 11:39:55 -0300)
>
> ----------------------------------------------------------------
> Python queue, 2017-09-22
>
> * MAINTAINERS update
> * Fix logging issue on test scripts using qemu.py
>
> ----------------------------------------------------------------
>
> Eduardo Habkost (2):
>   qemu.py: Call logging.basicConfig() automatically
>   MAINTAINERS: Add Python scripts
>
>  scripts/qemu.py | 3 +++
>  MAINTAINERS     | 8 ++++++++
>  2 files changed, 11 insertions(+)

Applied, thanks.

-- PMM
