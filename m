Received: from eggs.gnu.org ([2001:4830:134:3::10]:36702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fNKEv-0000J6-NG
	for qemu-devel@nongnu.org; Mon, 28 May 2018 11:39:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fNKEs-00078n-Lp
	for qemu-devel@nongnu.org; Mon, 28 May 2018 11:39:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51482 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fNKEs-00078Z-GJ
	for qemu-devel@nongnu.org; Mon, 28 May 2018 11:39:14 -0400
References: <20180528144509.15812-1-armbru@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d3808c8b-ccb9-2c84-bf53-b3a152f8c21f@redhat.com>
Date: Mon, 28 May 2018 17:39:11 +0200
MIME-Version: 1.0
In-Reply-To: <20180528144509.15812-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/4] qdev: remove
 DeviceClass::init/exit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: f4bug@amsat.org, ehabkost@redhat.com, peter.maydell@linaro.org, thuth@redhat.com

On 28/05/2018 16:45, Markus Armbruster wrote:
> This lovely series got stuck after v3, so I took the liberty to respin
> it.
> 
> v4:
> * PATCH 1+2 unchanged
> * PATCH 3+4 reshuffled a bit, missing documentation updates supplied

At long last!  Queued,t hanks.

Paolo
