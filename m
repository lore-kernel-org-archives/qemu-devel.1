Received: from eggs.gnu.org ([2001:4830:134:3::10]:50319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cRd0c-0007bQ-IQ
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 05:53:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cRd0Z-0002cU-IT
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 05:53:30 -0500
References: <20170104145624.2849-1-pbonzini@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <2ddc7888-3a12-68e3-dcce-df05a16e12a3@msgid.tls.msk.ru>
Date: Thu, 12 Jan 2017 13:53:26 +0300
MIME-Version: 1.0
In-Reply-To: <20170104145624.2849-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-img: remove dead check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

04.01.2017 17:56, Paolo Bonzini wrote:
> options must be non-NULL here, because it has been checked before.
> Reported by Coverity.

Applied to -trivial, thanks!

/mjt
