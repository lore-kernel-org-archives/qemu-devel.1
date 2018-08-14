Received: from eggs.gnu.org ([2001:4830:134:3::10]:41674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpUS8-0004be-NK
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 04:13:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpUS4-0006OM-Kj
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 04:13:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44030 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fpUS4-0006O8-ER
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 04:13:16 -0400
References: <20180813171132.21939-1-cota@braap.org>
	<20180813171132.21939-2-cota@braap.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d9bb9cc8-f9ab-83e9-106e-7f405c6793af@redhat.com>
Date: Tue, 14 Aug 2018 10:13:12 +0200
MIME-Version: 1.0
In-Reply-To: <20180813171132.21939-2-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] qsp: QEMU's Synchronization Profiler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>

On 13/08/2018 19:11, Emilio G. Cota wrote:
> +    struct qsp_report rep;

Don't like camelcase?  But that's really all that I have to remark on
this lovely series.

Paolo
