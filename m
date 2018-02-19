Received: from eggs.gnu.org ([2001:4830:134:3::10]:51144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1enjSo-00048s-FQ
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 06:18:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1enjSn-0005gk-II
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 06:18:30 -0500
Received: from mail-ot0-x235.google.com ([2607:f8b0:4003:c0f::235]:41060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1enjSn-0005gQ-Dg
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 06:18:29 -0500
Received: by mail-ot0-x235.google.com with SMTP id w38so8153485ota.8
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 03:18:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180219100812.12860-1-cohuck@redhat.com>
References: <20180219100812.12860-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Feb 2018 11:18:08 +0000
Message-ID: <CAFEAcA_wNaeZEZcT-pijkHhcZOzTx8mRDqZMUTRv8Pw84X1fwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] stable process documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>

On 19 February 2018 at 10:08, Cornelia Huck <cohuck@redhat.com> wrote:
> The following changes since commit e5ecc287a7bd24a1364e23e263cb60cfc8d21eb5:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-hmp-20180216' into staging (2018-02-16 18:39:05 +0000)
>
> are available in the git repository at:
>
>   git://github.com/cohuck/qemu tags/stable-doc-20180219
>
> for you to fetch changes up to 7aa54229cfd24935d5d7bcc48534fe01934f3f52:
>
>   docs: document our stable process (2018-02-19 10:51:16 +0100)
>
> ----------------------------------------------------------------
> Add some doc for the stable process.
>
> ----------------------------------------------------------------
>
> Cornelia Huck (1):
>   docs: document our stable process
>
>  docs/devel/stable-process.rst | 69 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 docs/devel/stable-process.rst
>


Applied, thanks.

-- PMM
