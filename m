Received: from eggs.gnu.org ([2001:4830:134:3::10]:44371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dUwO0-0001pj-Kd
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:43:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dUwNw-0000PQ-Pe
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:43:36 -0400
References: <20170707154646.22230-1-pbonzini@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <a304046a-e2f4-8d01-7011-971ca6db96c5@msgid.tls.msk.ru>
Date: Tue, 11 Jul 2017 17:43:23 +0300
MIME-Version: 1.0
In-Reply-To: <20170707154646.22230-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hxtool: remove dead -q option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, marcandre.lureau@redhat.com

07.07.2017 18:46, Paolo Bonzini wrote:
> This was used to extract .txt documentation for QMP.  This was
> changed to use the QAPI schema instead, so zap it.

Applied to -trivial, thanks!

/mjt
