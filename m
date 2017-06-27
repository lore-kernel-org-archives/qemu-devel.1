Received: from eggs.gnu.org ([2001:4830:134:3::10]:52140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dPqB9-0006bQ-4e
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 09:05:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dPqB4-00036U-7S
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 09:05:15 -0400
References: <20170626103756.22974-1-berrange@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <08d2a926-13f8-fa8a-6d0b-87525f10d9ce@msgid.tls.msk.ru>
Date: Tue, 27 Jun 2017 16:05:09 +0300
MIME-Version: 1.0
In-Reply-To: <20170626103756.22974-1-berrange@redhat.com>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] sockets: avoid formatting buffer that
 may not be NUL terminated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Applied to -trivial (with commit typo fix), thanks!

/mjt
