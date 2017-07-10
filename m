Received: from eggs.gnu.org ([2001:4830:134:3::10]:49994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUgYB-0007sH-VH
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 17:49:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUgY7-0003mO-5m
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 17:49:04 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:36504)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dUgY6-0003m1-VN
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 17:48:59 -0400
Received: by mail-wr0-f174.google.com with SMTP id c11so156937456wrc.3
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 14:48:58 -0700 (PDT)
References: <D5741445-7EFD-4AF1-8DB2-E4AFA93CBB1A@icloud.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d2f285a7-4bba-5ece-f327-fc4c5e61296e@redhat.com>
Date: Mon, 10 Jul 2017 23:48:55 +0200
MIME-Version: 1.0
In-Reply-To: <D5741445-7EFD-4AF1-8DB2-E4AFA93CBB1A@icloud.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] test-i386: Make x86 test program compile
 on clang
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Theodore Dubois <tblodt@icloud.com>, qemu-devel@nongnu.org

On 10/07/2017 22:57, Theodore Dubois wrote:
>   - Clang doesn't support size suffixes on the loop instructions.

Has this bug been reported?

Paolo
