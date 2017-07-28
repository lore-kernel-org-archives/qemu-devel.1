Received: from eggs.gnu.org ([2001:4830:134:3::10]:46698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1db3xT-0005zN-Ji
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:01:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1db3xQ-0004fO-R0
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:01:31 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:33453)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1db3xQ-0004ez-K4
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:01:28 -0400
Received: by mail-wm0-f54.google.com with SMTP id e199so5433700wmd.0
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 05:01:28 -0700 (PDT)
References: <20170728012542.29975-1-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <975681ad-8262-af4b-ecb7-8ec1f4379298@redhat.com>
Date: Fri, 28 Jul 2017 14:01:25 +0200
MIME-Version: 1.0
In-Reply-To: <20170728012542.29975-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.10 0/8] docs: fix broken paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

On 28/07/2017 03:25, Philippe Mathieu-Daudé wrote:
> Eric said this can wait 2.11, however these patches don't change any code
> generated, I think the 2.10 users deserve an up-to-date doc :p

I agree, especially because this is a 2.10 regression.

Paolo
