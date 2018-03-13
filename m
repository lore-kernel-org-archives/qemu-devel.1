Received: from eggs.gnu.org ([2001:4830:134:3::10]:41427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evoSy-0003zP-PU
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:16:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evoSx-0000hI-Vb
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:16:04 -0400
Received: from mail-ot0-x22f.google.com ([2607:f8b0:4003:c0f::22f]:41753)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1evoSx-0000gq-Q8
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:16:03 -0400
Received: by mail-ot0-x22f.google.com with SMTP id w38-v6so574497ota.8
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 11:16:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180312221132.14141-1-ehabkost@redhat.com>
References: <20180312221132.14141-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Mar 2018 18:15:42 +0000
Message-ID: <CAFEAcA-N7A6iHZOCRzhqY8zejNnVnPsJ3+TKNDKnVrE2yPcDew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] Python queue, 2018-03-12
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

On 12 March 2018 at 22:11, Eduardo Habkost <ehabkost@redhat.com> wrote:
> The following changes since commit 6ceb1b51f05f9e1892d082960ed602dca7b6696e:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/audio-20180312-pull-request' into staging (2018-03-12 16:14:37 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/python-next-pull-request
>
> for you to fetch changes up to 006cc558359d23f070c84d6db324bbb9b54962d7:
>
>   device-crash-test: Use 'python' binary (2018-03-12 19:10:16 -0300)
>
> ----------------------------------------------------------------
> Python queue, 2018-03-12
>
> ----------------------------------------------------------------
>
> Eduardo Habkost (4):
>   device-crash-test: New known crashes
>   qemu.py: Use items() instead of iteritems()
>   qmp.py: Encode json data before sending
>   device-crash-test: Use 'python' binary
>
>  scripts/qemu.py           | 2 +-
>  scripts/qmp/qmp.py        | 2 +-
>  scripts/device-crash-test | 6 +++++-
>  3 files changed, 7 insertions(+), 3 deletions(-)

Applied, thanks.

-- PMM
